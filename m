From: "Shanmugam, Shankar K" <SShanmugam@ciber.com>
Subject: Problem opening a file using NFS File System
Date: Mon, 4 Sep 2006 23:02:02 -0600
Message-ID: <F71A3F85F026644687388710AF44A200D07FC4@srv-corp-exmb5.ciber.cbr.inc>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi I'm working with OMAP5912, when I create/open a file with fopen() I'm =
getting the following error message:
Read-only file system=20
=20
The /etc/exports file is edited as:    /home/user/montavista/filesys =
*(rw,no_root_squash,no_all_squash,sync)
I can read the file successfully, but I have problem in writing to the =
file.
=20
How can I fix this problem ???
=20
=20
________________
=20
Thanks & Regards,
K.S.Shankar
