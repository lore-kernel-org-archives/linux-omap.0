From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC 1/8] drivers: add generic remoteproc framework
Date: Mon, 27 Jun 2011 17:35:49 -0600
Message-ID: <BANLkTi=MDSuiGb64Se1T7zCWG6syxXbhTg@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-2-git-send-email-ohad@wizery.com>
	<20110627204958.GB20865@ponder.secretlab.ca>
	<20110627232903.GB7736@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110627232903.GB7736@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Arnd Bergmann <arnd@arndb.de>, Brian Swetland <swetland@google.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 27, 2011 at 5:29 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 27, 2011 at 02:49:58PM -0600, Grant Likely wrote:
>> > +struct {
>> > + =A0 =A0 =A0char magic[4] =3D { 'R', 'P', 'R', 'C' };
>> > + =A0 =A0 =A0u32 version;
>> > + =A0 =A0 =A0u32 header_len;
>> > + =A0 =A0 =A0char header[...] =3D { header_len bytes of unformatted, t=
extual header };
>> > + =A0 =A0 =A0struct section {
>> > + =A0 =A0 =A0 =A0 =A0u32 type;
>> > + =A0 =A0 =A0 =A0 =A0u64 da;
>> > + =A0 =A0 =A0 =A0 =A0u32 len;
>> > + =A0 =A0 =A0 =A0 =A0u8 content[...] =3D { len bytes of binary data };
>> > + =A0 =A0 =A0} [ no limit on number of sections ];
>> > +} __packed;
>>
>> Other have commented on the image format, so I'll skip this bit other
>> than saying that I agree it would be great to have a common format.
>
> (Don't have the original message to reply to...)
>
> Do we really want to end up with header being 5 bytes, header_len set
> as 5, and having to load/store all this data using byte loads/stores ?
>
> If we don't want that, then I suggest we get rid of the packed attribute,
> and require stuff to be naturally aligned.
>
> First issue is that struct section could be much better layed out:
>
> struct section {
> =A0 =A0 =A0 =A0u32 type;
> =A0 =A0 =A0 =A0u32 len;
> =A0 =A0 =A0 =A0u64 da;
> =A0 =A0 =A0 =A0u8 content[];
> };
>
> and require sizeof(struct section) % sizeof(u64) =3D=3D 0 - iow, to find
> the next section, round len up to sizeof(u64). =A0Ditto for the header.

Hopefully this will all be moot since it has been proposed to use elf
images directly.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
