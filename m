From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage
	Scaling)
Date: Thu, 26 Apr 2012 20:11:59 +0100
Message-ID: <20120426191159.GA9415@sirena.org.uk>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Keerthy <j-keerthy@ti.com>
Cc: khilman@ti.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, j-pihet@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 26, 2012 at 11:10:31PM +0530, Keerthy wrote:
> From: J Keerthy <j-keerthy@ti.com>
> 
> AVS(Adaptive Voltage Scaling) is a power management technique which
> controls the operating voltage of a device in order to optimize (i.e. reduce)
> its power consumption. The voltage is adapted depending on static factors
> (chip manufacturing process) and dynamic factors (temperature
> depending performance).
> The TI AVS solution is named Smartreflex. 

What's the relationship between this and existing things like devfreq
and cpufreq?  It'd be better if the changelogs made this clear and
provided an overview of how all these different subsystems are intended
to fit together.
