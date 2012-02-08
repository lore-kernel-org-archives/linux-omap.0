From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v3 00/20] ARM: OMAP3+: SmartReflex: bugfixes
Date: Wed, 8 Feb 2012 18:52:34 +0100
Message-ID: <CAORVsuWX=KSaLWP=Pe-u-Djh1-vTDkWBamr5vWe_eiPi5p9c+Q@mail.gmail.com>
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
	<871uqdca5e.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62110 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781Ab2BHRwh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 12:52:37 -0500
Received: by vbjk17 with SMTP id k17so504202vbj.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 09:52:36 -0800 (PST)
In-Reply-To: <871uqdca5e.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Hi Kevin,

On Thu, Feb 2, 2012 at 8:23 PM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Integrate the latest SmartReflex bufixes from Felipe Balbi [1] and
>> Nishant Menon [2], plus misc bugfixes.
>>
>> Based on latest master branch of the mainline git tree (3.3.0-rc1) [=
3], commit
>> 27ba234c8dfe86c96675d4ef275d1d3c1f5f7053.
>>
>> [1] http://marc.info/?l=3Dlinux-omap&m=3D132134699423547&w=3D2
>> [2] https://github.com/nmenon/linux-omap-ti-pm/commits/linux-omap-3.=
0
>> [3] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=
=3Dshortlog
>
> Can you break this series up further?
>
> There is lots of stuff in this series that does not qualify as a fix =
or
> a cleanup. =A0(specifically, all the ones starting with "introduce...=
").
>
> We need to keep fixes and cleanups separate from new features.
Just re-sent the series with the bugfixes and minor clean-ups only, as
'[PATCH v4 00/14] ARM: OMAP3+: SmartReflex: bugfixes and clean-ups'.
This is based on 3.3-rc2 from mainline.

The new functionality will be added as patch series on top of this one.

>
> Kevin

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
