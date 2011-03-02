From: Greg KH <greg@kroah.com>
Subject: Re: linux-next: manual merge of the usb tree with the omap tree
Date: Wed, 2 Mar 2011 09:23:22 -0500
Message-ID: <20110302142322.GA2889@kroah.com>
References: <20110302165746.814a45a3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110302165746.814a45a3.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 02, 2011 at 04:57:46PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the usb tree got a conflict in
> drivers/usb/musb/musb_core.h between commit
> 59b479e0985f0b795d68331d6443a7f89c47768d ("omap: Start using
> CONFIG_SOC_OMAP") from the omap tree and commit
> da68ccec210c45eb99e461ad31b499b4e7043c41 ("usb: musb: Remove platform
> context save/restore API") from the usb tree.
> 
> The latter removed the code modified by the former, so I did that.

Thanks.  I'll let Felipe handle all of these omap merge issues, as I
thought the reason I was going to take these patches from him was to
prevent issues like this from happening :)

greg k-h
