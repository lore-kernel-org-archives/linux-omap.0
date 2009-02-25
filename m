From: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] MUSB and TWL4030-USB fixes
Date: Wed, 25 Feb 2009 20:50:31 +0900
Message-ID: <4d34a0a70902250350i3f27cff3r294346f3f22da14d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

These fixes are the replacement of [ARM: OMAP: Disable USB interrupt
in the musb_resume() function] and trying to following David
Brownell's recommendation.

Thanks, especially David.

-- 
Kyuwon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
