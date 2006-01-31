From: David Cohen <david.cohen@indt.org.br>
Subject: gpio-switch problem
Date: Tue, 31 Jan 2006 09:48:24 -0400
Message-ID: <43DF6AA8.3070200@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Linux-omap-open-source@linux.omap.com" <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

I am trying to use the gpio-switch driver, but I am getting a problem
when a new gpio switch is been registered. On new_switch function
(gpio-switch.c file), the platform_device_register is returning a error.
Has anyone already used, sucessfully, the gpio-switch driver?

Regards,

David Cohen
