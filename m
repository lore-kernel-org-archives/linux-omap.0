From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 6/6] omap: iommu: code reorganization and cleanup
Date: Sun, 7 Nov 2010 10:27:39 -0600
Message-ID: <AANLkTimt5YcOFKasa-q4ybpfTGh7361VpUjPOFa3a_ee@mail.gmail.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-7-git-send-email-omar.ramirez@ti.com>
	<4CD5C88E.5050009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:54525 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753463Ab0KGQ1k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Nov 2010 11:27:40 -0500
Received: by mail-iw0-f181.google.com with SMTP id 3so6019835iwn.26
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 08:27:39 -0800 (PST)
In-Reply-To: <4CD5C88E.5050009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Nov 6, 2010 at 4:28 PM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
> On 11/5/2010 9:19 PM, Ramirez Luna, Omar wrote:
>>
>> Since omap-iommu is now using hwmod, there are structures and
>> arrays that can be cleaned up to increase the readability of
>> the code.
>
> This patch should be merged with the previous one as well.

No problem.

> I do not see the need to split in 3 patches these changes.
> It will be much readable and will avoid people, like me, doing commen=
t on a
> piece of code you will remove 2 patches later.
> That cleanup must be done when the hwmod is introduced since that cod=
e was
> already useless at that time.

Yes, I was trying to avoid mixing changes so the review could be
focused on the replacements only, it seems it backfired.

Will do it in one patch and see how it looks.

>> +static char *omap4_devices[] =3D {
>> + =A0 =A0 =A0 "ducati",
>> + =A0 =A0 =A0 "tesla",
>> + =A0 =A0 =A0 NULL,
>
> Not needed if you iterate over the class.

Ok.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
