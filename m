From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: HDQ/1-wire module
Date: Wed, 7 Nov 2007 14:12:15 +0530
Message-ID: <005a01c8211a$1a143f60$918818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All,

This is regarding the HDQ/1-wire support for omap24xx/34xx. 

The controller on the above OMAP platforms supports both HDQ and 1-wire protocol.The difference between HDQ and 1-wire protocol is
very minimal as explained below.

HDQ Mode:
In HDQ mode, the firmware does not require the host to create an initialization pulse to the slave.
However, the slave can be reset by using an initialization pulse (also referred to as a break pulse).
The slave does not respond with a presence pulse.

1-Wire Mode:
In 1-Wire protocol, the host first sends an initialization pulse (by pulling the line to a logic-low state)
and then waits for the slave to respond with a presence pulse before enabling any communication sequence.

A typical application of the HDQ/1-Wire module is the communication with battery monitor (gas gauge)
integrated circuits.

Has anyone in the past worked on the above module or has written a driver for the same? I can not recollect of having read any mails
on the above module
in the list. Please correct me if I am wrong.

There is no support for HDQ devices as of today in Linux. Whereas there is a W1 subsystem for 1-wire devices. Right now, I only have
a device 
that is complaint to HDQ protocol only.I guess we can still write a driver to support this which can be integrated to the 1-wire
subsystem. If anyone has a different opinion, please do share the views.

Regards,
Madhu
