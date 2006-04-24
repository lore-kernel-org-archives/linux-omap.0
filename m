From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: OSK RAM damage?
Date: Mon, 24 Apr 2006 16:02:40 +0900 (JST)
Message-ID: <20060424.160240.74753145.kaminaga@sm.sony.co.jp>
References: <4448491c.45fa3ac3.3d8f.ffff86aa@mx.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <4448491c.45fa3ac3.3d8f.ffff86aa@mx.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: iaadoa@gmail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

From: "Li Weichen" <iaadoa@gmail.com>
> I guess the RAM my OSK is damaged!
...
> Does it means that the ram is damaged?

You might want to check the EMIFF register settings.

http://omap.spectrumdigital.com/osk5912/osk5912_faq.html#E.1

This talks about the DDR SDRAM refresh rate.
Hope this would solve your problem.


Best Regards,

(Hiroki Kaminaga)
t
--
