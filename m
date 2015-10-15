From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes against v4.3-rc5
Date: Thu, 15 Oct 2015 17:14:17 +0200
Message-ID: <6230685.TX0FKXpebS@wuerfel>
References: <20151014200336.GJ10113@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151014200336.GJ10113@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 14 October 2015 13:03:36 Tony Lindgren wrote:
> Fixes for omap against v4.3-rc5:
> 
> - Regulator fix for beagle-x15 to fix HDMI without a SD card being
>   inserted
> 
> - GPMC fix for showing proper timings and to allow enabling debug
>   options that somehow was unselectable earlier
> 
> - Add minimal documentation for new MMC1 dependency on
>   REGULATOR_PBIAS as it may not be obvious for people with
>   targeted .config files
> 

Pulled into fixes, thanks!

	Arnd
