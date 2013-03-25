From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv2 09/12] staging: ti-soc-thermal: fix several kernel-doc
 warnings and error
Date: Mon, 25 Mar 2013 11:22:26 -0700
Message-ID: <20130325182226.GA15717@kroah.com>
References: <1363704868-11843-1-git-send-email-eduardo.valentin@ti.com>
 <1363704868-11843-10-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363704868-11843-10-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: devel@driverdev.osuosl.org, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 19, 2013 at 10:54:25AM -0400, Eduardo Valentin wrote:
> This patch updates the documentation to remove
> all warnings and errors reported by scripts/kernel-doc.
> Most are missing arguments due to wrong format.
> 
> Cc: Nishanth Menon <nm@ti.com>
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

In the future, don't put empty lines between the Cc: and signed-off-by:
lines please, I had to hand-edit all of these to fix that...

greg k-h
