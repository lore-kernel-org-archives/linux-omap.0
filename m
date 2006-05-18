From: Matthew Percival <matthew@capgo.com>
Subject: Re: OSK5912 Deep Sleep
Date: Fri, 19 May 2006 09:37:58 +1000
Message-ID: <1147995478.8928.3.camel@localhost.localdomain>
References: <446C7FC0.4070503@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <446C7FC0.4070503@web.de>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

> maybe my questions are too simple, but i?ll try again.
> how can i set the osk5912 into deep sleep mode? i use the montavista 
> preview kit.

	Deep Sleep is nice and easy to do.  Try this at a prompt:
		# echo "standby" > /sys/power/state
Unless something goes wrong, your system will now be in Deep Sleep.

	-- Matthew
