From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2 0/4] Fixes to twl4030-madc and add BeagleBoard support
Date: Mon, 22 Aug 2011 15:55:30 +0200
Message-ID: <20110822135530.GR4607@sortiz-mobl>
References: <CANOLnOPB=wFMPwqGbu9ufh__iM7TquUx3-o95R=gyJcae+gENg@mail.gmail.com>
	<1313119995-15382-1-git-send-email-kyle@kylemanna.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1313119995-15382-1-git-send-email-kyle@kylemanna.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kyle Manna <kyle@kylemanna.com>
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Kyle,

On Thu, Aug 11, 2011 at 10:33:11PM -0500, Kyle Manna wrote:
> These patches add basic functionality to the twl4030-madc driver to make
> it work on the BeagleBoard xM.
> 
> Version 2 adds fixes per Grazvydas Ignotas and the check for NULL pointer patch.
> 
> Kyle Manna (4):
>   mfd: twl4030-madc: copy the device pointer
>   mfd: twl4030-madc: turn on the MADC clock
>   mfd: twl4030-madc: check for NULL pointer
>   arm: BeagleBoard: add support for the twl4030-madc
Tony, are you ok with the BeagleBoard changes ?
The MFD ones look fine to me, I'd like to apply them.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
