From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/23] ARM: dts: n950: add display support
Date: Tue, 12 Apr 2016 13:51:48 -0700
Message-ID: <20160412205148.GY5995@atomide.com>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-3-git-send-email-sre@kernel.org>
 <21766689.NesyW3QHk4@avalon>
 <20160317174901.GB3864@earth>
 <87lh59pdt6.fsf@intel.com>
 <20160323140105.GA31703@earth>
 <87h9fwdwh6.fsf@intel.com>
 <20160324142652.GA25083@earth>
 <87io0b52ss.fsf@intel.com>
 <20160325001509.GA12097@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160325001509.GA12097@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [160324 17:16]:
> On Thu, Mar 24, 2016 at 05:11:15PM +0200, Jani Nikula wrote:
> > > I _think_, that your HW team decided to cover the first and the
> > > last few pixels of the 864 display with plastic. So technically
> > > it's a 864 display, but effectively it's 854.

Sebastian, should I apply this dts patch as is or are changes
still needed?

Tony
