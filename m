From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: arm system wide sram support
Date: Fri, 13 Jul 2012 09:55:11 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA3F274@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "rmk+kernel@arm.linux.org.uk" <rmk+kernel@arm.linux.org.uk>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>
List-Id: linux-omap@vger.kernel.org

Hi,

I have started working on Audio support for TI AM335x SOC. 
It uses the same McASP IP as in Davinci platform.

The mcasp driver (davinci-pcm) uses SRAM api's. 
Currently OMAP & Davinci have their own allocation systems, and both with
their own ways of copying functions into the SRAM.

A Patch was floating in the ML which supported merging this functionality
as a unified consolidated sram support. 

https://patchwork.kernel.org/patch/961222/

However I believe the patch was not accepted and I couldn't find any 
updates on it later.

Can someone give me some pointers about the status for this patch or 
If there has been any update on this?

Is anyone working on this consolidation?

Thanks & Regards
Gururaja
