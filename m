From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/3] drivers: bus: ocp2scp: add pdata support
Date: Tue, 16 Oct 2012 09:50:43 -0700
Message-ID: <20121016165043.GS15569@atomide.com>
References: <1349675983-23803-1-git-send-email-kishon@ti.com>
 <1349675983-23803-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1349675983-23803-2-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, arnd@arndb.de, olof@lixom.net, rdunlap@xenotime.net, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [121007 23:01]:
> ocp2scp was not having pdata support which makes *musb* fail for non-dt
> boot in OMAP platform. The pdata will have information about the devices
> that is connected to ocp2scp. ocp2scp driver will now make use of this
> information to create the devices that is attached to ocp2scp.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

This fixes the regression on my panda es for musb port:

Acked-by: Tony Lindgren <tony@atomide.com>
