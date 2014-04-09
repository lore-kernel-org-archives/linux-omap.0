From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] usb: rename 'phy' field of 'struct usb_hcd' to
 'transceiver'
Date: Wed, 9 Apr 2014 13:56:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1404091354560.28384-100000@netrider.rowland.org>
References: <534588F1.2050406@cogentembedded.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <534588F1.2050406@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, Peter.Chen@freescale.com, thierry.reding@gmail.com, balbi@ti.com, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-omap@vger.kernel.org

On Wed, 9 Apr 2014, Sergei Shtylyov wrote:

> > Ok, the existing field is being replaced by something? I didn't get that
> 
>     No, not replaced. I'm adding the support for generic PHY to the existing 
> USB PHY support. I thought that was clear from the changelog.
> 
> > from the patch description; I thought the new name in this patch was
> > going to be it. In that case, a temporary name of usb_phy for the
> > existing field, or adding the new field as gen_phy sound reasonable.
> 
>     OK, I'll respin the patch #2 with 'gen_phy' and remove the patch #1.

What is the reason for all of this?  That is, can you explain the
difference between USB PHY support and general PHY support, and why we
need both?

Alan Stern

