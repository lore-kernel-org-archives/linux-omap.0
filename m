From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv3 00/41] OMAPDSS: DT support v3
Date: Tue, 21 Jan 2014 15:29:20 -0600
Message-ID: <52DEE6B0.20106@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Darren Etheridge <detheridge@ti.com>, Sebastian Reichel <sre@ring0.de>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, Stefan Roese <stefan.roese@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Robert Nelson <robertcnelson@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Florian Vaussard <florian.vaussard@epfl.ch>
List-Id: linux-omap@vger.kernel.org

Tomi,

On 01/21/2014 04:56 AM, Tomi Valkeinen wrote:
> Hi,
> 
> Here's version 3 of the DSS DT series.
> 
> The previous version can be found from:
> 
> v1: http://permalink.gmane.org/gmane.linux.ports.arm.omap/108249
> v2: http://permalink.gmane.org/gmane.linux.ports.arm.omap/108866
> 
> The main changes to v2 are:
> 
> - DT Binding documentation
> - OMAP2 DSS support
> - Split DSI register space
> - DSS nodes disabled by default
> - Hack to have generic DT bindings but OMAP specific drivers (for now)
> 
> This series can also be found from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt-review-3
> 
http://slexy.org/view/s20JhteOFR is my quick build test report -> few
checkpatch and build bisect issues would probably need fixing.



-- 
Regards,
Nishanth Menon
