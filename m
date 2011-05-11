From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH RESEND] omap : nand : fix subpage ecc issue
	with prefetch
Date: Wed, 11 May 2011 21:07:55 +0530
Message-ID: <BANLkTinsZsBhVbcGRnx0fzWwA2Q0f4Fs3w@mail.gmail.com>
References: <1305123897-11371-1-git-send-email-kishore.kadiyala@ti.com>
	<20110511145431.GA18317@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-bounces@linux.kernel.org>
In-Reply-To: <20110511145431.GA18317@kroah.com>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: Greg KH <greg@kroah.com>
Cc: dedekind1@gmail.com, Kishore Kadiyala <kishore.kadiyala@ti.com>, Vimal Singh <vimal.newwork@gmail.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, stable@kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 11, 2011 at 8:24 PM, Greg KH <greg@kroah.com> wrote:
> On Wed, May 11, 2011 at 07:54:57PM +0530, Kishore Kadiyala wrote:
>> When reading/writing a subpage (When HW ECC is not available/enabled)
>> for number of bytes not aligned to 4, the mis-aligned bytes are handled
>> first (by cpu copy method) before enabling the Prefetch engine to/from
>> 'p'(start of buffer 'buf'). Then it reads/writes rest of the bytes with
>> the help of Prefetch engine, if available, or again using cpu copy metho=
d.
>> Currently, reading/writing of rest of bytes, is not done correctly since
>> its trying to read/write again to/from begining of buffer 'buf',
>> overwriting the mis-aligned bytes.
>>
>> Read & write using prefetch engine got broken in commit '2c01946c'.
>> We never hit a scenario of not getting 'gpmc_prefetch_enable' call
>> success. So, problem did not get caught up.
>>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> Signed-off-by: Vimal Singh <vimal.newwork@gmail.com>
>> Reported-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
>> ---
>> =A0drivers/mtd/nand/omap2.c | =A0 12 +++++-------
>> =A01 files changed, 5 insertions(+), 7 deletions(-)
>
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree. =A0Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.

Ok, will post it properly.

Regards,
Kishore
>
> </formletter>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
>

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable
