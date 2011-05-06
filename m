From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] omap : nand : fix subpage ecc issue with prefetch
Date: Fri, 6 May 2011 13:00:47 +0530
Message-ID: <BANLkTi=6wkqWA+kjWShiEyFiVs0ZXqY6iw@mail.gmail.com>
References: <1304334638-2198-1-git-send-email-kishore.kadiyala@ti.com> <1304621338.7222.55.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53806 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab1EFHbI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 03:31:08 -0400
Received: by wya21 with SMTP id 21so2190587wya.19
        for <linux-omap@vger.kernel.org>; Fri, 06 May 2011 00:31:07 -0700 (PDT)
In-Reply-To: <1304621338.7222.55.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com
Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, bdefaria@adeneo-embedded.com

On Fri, May 6, 2011 at 12:18 AM, Artem Bityutskiy <dedekind1@gmail.com>=
 wrote:
> On Mon, 2011-05-02 at 16:40 +0530, Kishore Kadiyala wrote:
>> For prefetch engine, read and write =A0got broken in commit '2c01946=
c'.
>> We never hit a scenario of not getting 'gpmc_prefetch_enable'
>> call success.
>> When reading/writing a subpage with a non divisible by 4 ecc number
>> of bytes, the mis-aligned bytes gets handled first before enabling
>> the Prefetch engine, then it reads/writes rest of the bytes.
>>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> Signed-off-by: Vimal Singh <vimal.newwork@gmail.com>
>> Reported-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
>
> This needs a better commit message with more explanation and analysis=
 of
> the problem and how it was fixed.This commit message is not very
> understandable. And then it needs also:

How about a commit log like this:

When reading/writing a subpage (When HW ECC is not available/enable)
for number of bytes not aligned to 4, the mis-aligned bytes gets
handled first (by cpu copy mathod) before enabling the Prefetch
engin to/from 'p' (start of buffer 'buf').
Then it reads/writes rest of the bytes with the help of Prefetch
engine, if available, or again by cpu copy mathod. Currnetly,
reading/writing of rest of bytes, is not done correctly. Its trying to
read/write again to/from begining of buffer 'buf', overwriting the
mis-aligned bytes.

=46or prefetch engine read and write it got broken in commit '2c01946c'=
=2E
And we never hit the scenario of not getting 'gpmc_prefetch_enable'
call sucess. So, problem did not get caught up.

This patch fixes the issue.

> Cc: stable@kernel.org [2.6.36+]
>
> Right? And then we could send it upstream.

Yes, sure. I think kishore can take care of adding this in 'cc'
while posting next time.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
