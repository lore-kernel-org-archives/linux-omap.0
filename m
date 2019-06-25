From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: nl80211 wlcore regression in next
Date: Tue, 25 Jun 2019 10:57:27 +0200
Message-ID: <f41ef885311c30539fde5d5b696866a63b79f17b.camel@sipsolutions.net>
References: <20190625073837.GG5447@atomide.com>
         <2570f4087d6e3356df34635a0380ec8ce06c9159.camel@sipsolutions.net>
         <20190625080019.GH5447@atomide.com>
         <7f74087fef1e554e0aeb82a6cec4113727487928.camel@sipsolutions.net>
         <a863a74f-c6a9-b862-d17e-bc5f1dbe980a@broadcom.com>
         (sfid-20190625_105642_518599_389D67F7)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a863a74f-c6a9-b862-d17e-bc5f1dbe980a@broadcom.com> (sfid-20190625_105642_518599_389D67F7)
Sender: linux-kernel-owner@vger.kernel.org
To: Arend Van Spriel <arend.vanspriel@broadcom.com>, Tony Lindgren <tony@atomide.com>
Cc: Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalreizer@gmail.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Arend,


> By chance noticed the patch included brcmfmac. So I tried, but I get 
> compile issue below. It is because ERR_PTR really is an inline function 
> so that is not working. So also need to patch that. I left the extra 
> braces around the error code although not strictly necessary.

D'oh. I'll check that out, thanks for the report/patch!

johannes
