From: Vivien Chappelier <vivien.chappelier@free.fr>
Subject: HTC smartphones support patch set
Date: Sat, 09 Jun 2007 19:03:20 +0200
Message-ID: <466ADD58.6040608@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello,

The following patches add support for some of the HTC smartphones:
- HTC Typhoon, based on the OMAP730 platform
- HTC Hurricane and Tornado, based on the OMAP850 platform

As these phone are very similar, a single MACHINE_TYPE_TYPHOON is used 
for all
phones and runtime detection of the model is performed at boot time. The 
goal
is to extend support for other models later.

These patches provide support for the following devices:
- LCD panel and framebuffer
- USB as a slave device
- MMC/SD controller
- Keypad
- Leds

For more information on the project, see the page:
http://vivien.chappelier.free.fr/typhoon/index.html

The patches have been stable for some time now, with updates consisting 
mostly
in catching up with the omap tree. They also provide some generic fixes for
OMAP730, so I am submitting them for inclusion in the omap tree.
Please review and comment, if something cannot be applied, I will gladly
improve it and resubmit it later based on your remarks.

Thanks,
Vivien.
