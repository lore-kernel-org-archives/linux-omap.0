From: "Shanmugam, Shankar K" <SShanmugam@ciber.com>
Subject: Problem while creating a new directory on OMAP5912
Date: Tue, 5 Sep 2006 08:46:17 -0600
Message-ID: <F71A3F85F026644687388710AF44A200D07FCD@srv-corp-exmb5.ciber.cbr.inc>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
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

Hi. I'm facing a problem while creating a directory in OSK Session=20
This is what I get after executing mkdir on OSK board
=20
# mkdir usb
mkdir: Cannot create directory `usb': Read-only file system
=20
I have edited /etc/exports with following:
/home/user/montavista/filesys   *(rw,no_root_squash,no_all_squash,sync)
 And even I have set bootargs of OSK in 'rw' mode, but still I/m getting =
the same error when I do any file write operation.=20
=20
Please give me some relevant solution.
=20
=20
Thanks & Regards,
K.S.Shankar
