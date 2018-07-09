From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] Add DT support for Octavo Systems OSD3358-SM-RED
 based on TI AM335x
Date: Mon, 9 Jul 2018 03:50:36 -0700
Message-ID: <20180709105036.GC99251@atomide.com>
References: <20180706200051.1115-1-neeraj.dantu@octavosystems.com>
 <20180709104641.GB99251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180709104641.GB99251@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Neeraj Dantu <dantuguf14105@gmail.com>
Cc: devicetree@vger.kernel.org, Jason Kridner <jkridner@gmail.com>, Neeraj Dantu <neeraj.dantu@octavosystems.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180709 10:49]:
> * Neeraj Dantu <dantuguf14105@gmail.com> [180706 13:04]:
> > OSD3358-SM-RED is a dev board for OSD335x System-in-Package(SiP) devices from
> > Octavo Systems.
> 
> Applying into omap-for-v4.19/dt thanks.

Hmm dropping patch as it fails to build with make dtbs:

Error: arch/arm/boot/dts/am335x-osd3358-sm-red.dts:146.20-21 syntax error
FATAL ERROR: Unable to parse input tree

Can you please check against current Linux next and make sure it
builds and boots and then repost one more time?

Thanks,

Tony
