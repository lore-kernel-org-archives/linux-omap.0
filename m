From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Mon, 17 Jan 2011 15:46:44 +0000
Message-ID: <AANLkTinJPyXKWwbyW05+HUW0LJUxsu=1Exbrr6ut27Kr@mail.gmail.com>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
	<20110114155806.GA22505@n2100.arm.linux.org.uk>
	<AANLkTikz_gSQE5QfO6ZXwbp9w+HTNMtb6RLBY+3Z0XF6@mail.gmail.com>
	<20110114173400.GB22505@n2100.arm.linux.org.uk>
	<AANLkTim9At1MZmid1jqqCJAk28BPo0aJEf7QkZM=y4h2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTim9At1MZmid1jqqCJAk28BPo0aJEf7QkZM=y4h2@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 17, 2011 at 2:01 PM, Jean Pihet <jean.pihet@newoldbits.com> wro=
te:
> On Fri, Jan 14, 2011 at 6:34 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Jan 14, 2011 at 05:13:01PM +0100, Jean Pihet wrote:
>>> Is the name 'omap_sram_push' wrong then?
>>> What about the following?
>>> @@ -251,9 +251,8 @@ void * omap_sram_push(void * start, unsigned long s=
ize)
>>>
>>> =A0 =A0 =A0 =A0omap_sram_ceil -=3D size;
>>> =A0 =A0 =A0 =A0omap_sram_ceil =3D ROUND_DOWN(omap_sram_ceil, sizeof(voi=
d *));
>>> =A0- =A0 =A0 memcpy((void *)omap_sram_ceil, start, size);
>>> =A0- =A0 =A0 flush_icache_range((unsigned long)omap_sram_ceil,
>>> =A0- =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)(omap_sram_ceil + size));
>>>
>>> =A0- =A0 =A0 return (void *)omap_sram_ceil;
>>> =A0+ =A0 =A0return fncpy((void *)omap_sram_ceil, start, size);
>>
>> It's more correct, but still missing out on the type safety which we've
>> tried to provide with fncpy.
> IIUC the type of the function is propagated from the 2nd argument
> (funcp) to the return value, which is fine here. The (void)* is here
> only to avoid a warning thrown by memcpy.

I think Russell's argument was that the compiler will not notice if
you mismatch the return type and the function to be copied, because
the casts to/from void * make the compiler blind to the real types
involved.  So:

int f(int);
size_t size_of_f;

void *buffer;
int (*_copied_f1)(int);
char *(*_copied_f2)(char *);

_copied_f1 =3D fncpy(buffer, f, size_of_f); /* OK */
_copied_f2 =3D fncpy(buffer, f, size_of_f); /* compile error */
_copied_f1 =3D omap_sram_push(f, size_of_f); /* OK */
_copied_f2 =3D opam_sram_push(f, size_of_f); /* type mismatch, but
compilation succeeds */


One way to work around this is would be to make omap_sram_push() a macro:

#define omap_sram_push(funcp, size) \
    (typeof(funcp))_do_omap_sram_push((void *)(funcp), size)

... where the definition of _do_omap_sram_push() is the same is the
existing definition of omap_sram_push().  Providing
_do_omap_sram_push() is not called directly, this should now be
type-safe.


Cheers
---Dave
