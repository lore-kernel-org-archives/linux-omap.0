From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] CBUS: retu-headset updates
Date: Thu, 1 Nov 2007 02:04:13 -0700
Message-ID: <20071101090412.GD780@atomide.com>
References: <1193832282-10044-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1193832282-10044-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: jarkko.nikula@nokia.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* jarkko.nikula@nokia.com <jarkko.nikula@nokia.com> [071031 05:04]:
> Some updates to retu-headset driver picked from internal tree. That's the only
> reason why feature implemented in patch 2 is before fix in patch 3 :-)
> 
> Note about bias voltage: external mic doesn't need it while device is in
> suspend (hard with sales HW due the watchdogs...) and this can save mA or so
> the suspend current. However, button detection is kept active since it can
> wake-up the system.

Pushing all three today.

Tony
