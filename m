From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: Re: [resend PATCH 1/3] pinctrl: dra7: dt-bindings: add pin off modes
 for dra7 SoC
Date: Tue, 9 Sep 2014 14:47:09 +0530
Message-ID: <540EC595.2050301@ti.com>
References: <1410203998-8700-1-git-send-email-mugunthanvnm@ti.com> <1410203998-8700-2-git-send-email-mugunthanvnm@ti.com> <20140908193235.GA12150@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140908193235.GA12150@kahuna>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 09 September 2014 01:02 AM, Nishanth Menon wrote:
> A) There is no OFF mode on DRA7. in sleep state use mode 15 (gated).
> B) when using this for wakeup - use pinctrl wakeup handling to do the
> wakeup.

Will drop this patch and use mode 15 in sleep mode and submit v2 patch
series

Regards
Mugunthan V N
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
