From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Thu, 26 Sep 2013 10:21:57 -0500
Message-ID: <52445115.7010800@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380098922-30340-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/25/2013 03:48 AM, Tero Kristo wrote:
[...]
> Test branch available here:
> https://github.com/t-kristo/linux-pm.git
> branch: mainline-3.12-rc2-ti-dt-clks-v7
> 
> Testing done:
> - am335x-bone : boot only
> - omap5-sevm : boot only
> - dra7-evm : boot only
> - omap3-beagle : boot + suspend/resume (ret + off)
> - omap4-panda-es : boot + suspend/resume
> 
> Nishanth has also been doing some tests with omap3-beagle-xm with some WIP
> versions of this branch, but not with this latest one. Nishanth, maybe you
> can provide test results to this one also?
I rebased the branch on top of benoit's for_3.13/dts merged with
v3.12-rc2 tag
45646cd ARM: dts: AM33XX: don't redefine OCP bus and device nodes

All platforms were to MMC filesystem boot (SD card). u-boot used
v2013.10-rc3 on all platforms (mainline u-boot).

OMAP3630: Beagle-XM:
http://pastebin.pandaboard.org/index.php/view/96577127
(needs additional patch
-> https://patchwork.kernel.org/patch/2919661/ )

OMAP4460: Panda-ES: http://pastebin.pandaboard.org/index.php/view/85143661

OMAP5432: OMAP5-UEVM:
http://pastebin.pandaboard.org/index.php/view/91361843
(nice to have patch
-> https://patchwork.kernel.org/patch/2907761/ )

AM335x: BeagleBone Black:
http://pastebin.pandaboard.org/index.php/view/42000597
(needs additional patches:
 https://patchwork.kernel.org/patch/2902711/
 https://patchwork.kernel.org/patch/2902711/
)

DRA7: DRA7-EVM: http://pastebin.pandaboard.org/index.php/view/38362805
(needs additional patches:
-> https://patchwork.kernel.org/patch/2849391/
-> https://patchwork.kernel.org/patch/2849601/
-> https://patchwork.kernel.org/patch/2849602/
-> https://patchwork.kernel.org/patch/2907761/
)

So, for the entire series:
Tested-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
