From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [resend PATCH 0/3] Add DRA7xx CPSW Ethernet support in Device Tree
Date: Tue, 9 Sep 2014 07:15:49 -0500
Message-ID: <CAGo_u6riiMVTW2y1qZWdJ2QUVdxX7uZyaTO3tRTGivX8Pjni1w@mail.gmail.com>
References: <1410203998-8700-1-git-send-email-mugunthanvnm@ti.com>
	<20140908193440.GC12150@kahuna>
	<540EE4B0.70207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <540EE4B0.70207-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, dt list <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 9, 2014 at 6:29 AM, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org> wrote:
>
>> Sorry this is now blocked inside TI. could you explain the testing done
>> for sleep state? did you attempt sleep mode before testing this?
>>
>
> I have not tested sleep mode, just tested boot and ping test.

I must NAK then for the reason that this is a patch that is just build
tested and is not tested for the feature it claims to introduce.


-- 
---
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
