From: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Fri, 13 Mar 2015 19:38:59 +0100
Message-ID: <CAALWOA-sdLzUP8_6BKvsDQeAqxCw5-n410u3=W3D5yaCLYChbQ@mail.gmail.com>
References: <20150309205157.GE5140@atomide.com> <CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
 <20150309211306.GC22341@saruman.tx.rr.com> <CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
 <20150309212014.GE22341@saruman.tx.rr.com> <20150309212622.GJ5264@atomide.com>
 <CADYTM3ZW5e5dCQbbaE02o7wxOC26+jo5Ddo+2B4Q6UCAT2pTdQ@mail.gmail.com> <20150309214129.GK5264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150309214129.GK5264-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Given that the documentation mentions the actual phy used, it may be
worth mentioning this also in the driver?  i.e. that it's not a
"dm816x phy" but a "SR70LX Synopsys USB 2.0 OTG nanoPHY" (in contrast
to the dm814x and am335x which use a phy TI made themselves)

USB is one of the few subsystems of the DM814x I've never really
examined in any detail, but it appears nearly identical to the AM335x.
(e.g. the phy registers in the control module are nearly identical,
differing only in some bits related to GPIO-mode)


On 9 March 2015 at 22:41, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> Note that we still are missing basic support for dm814x in mainline,
> I'm planning to tackle that at some point but I don't know when I'm
> going to get to it..

Do ping me if you have questions. While I still don't have time to
really throw myself on the task myself, and I'm still hindered by
insufficient knowledge of the kernel, I do have quite a bit of
experience with the processor itself.


BTW, w.r.t. the old "official" TI kernel for dm81xx: there are
actually two relevant forks of the unmaintained
arago-omap3/ti81xx-master branch, namely:

http://arago-project.org/git/projects/?p=linux-ipnc-rdk-dm81xx.git
http://arago-project.org/git/projects/?p=linux-dvr-rdk-dm81xx.git

which contain various bugfixes, including for usb (though also patches
specific to those SDKs).
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
