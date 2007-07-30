From: "Amit Gupta" <amitjobs05@gmail.com>
Subject: FSUSB Port on OMAP2430 SDP
Date: Tue, 31 Jul 2007 01:04:18 +0530
Message-ID: <78d6ed630707301234k2b14adb9mec1aecfd50a5eb22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hello

I am using OMAP 2430 SDP v4.0 and trying to configure the FS USB port 0(J51
on the main board) as host. I am using kernel v2.6.14



I am not getting any of the interrupts after connecting the cable/and
device. And the device (mass storage device) is not getting configured.



=B7        Does the port need to configure as OTG port and then make it as
host? That's how it seems to me from the code.



=B7        Do we need to make any changes in the files for making it to wor=
k?
Also kindly send the config file for the same.

 Thanks & Regards

Amit
