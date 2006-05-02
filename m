From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 0/3] aic23 sound driver fixes
Date: Tue, 02 May 2006 23:38:53 +0300
Message-ID: <4457C35D.4020700@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Following patch set should fix the broken method references to from Alsa
and OSS drivers to tlv320aic23 i2c drivers that has been reported.
In addition the 3:rd patch contains the platform driver code that the
innovator requires if it wants to use alsa driver.

I do not own myself the innovator or aic23 drivers so it would be nice
if someone else could test these.

Mika
