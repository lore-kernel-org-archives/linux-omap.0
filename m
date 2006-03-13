From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: How to solve "lsmod :QM_MODULES: Function not implemented."?
Date: Mon, 13 Mar 2006 09:05:11 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA6028D800B@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Keria Seymour <subsun.ece94g@nctu.edu.tw>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Most likely you are using a file system that has wrong module dependency
info. I saw this error when I tried to insmod from a MontaVista CEE3.1
file system which has module info. The insmod worked fine after I have
switched to a file system that doesn't have module info.

Regards,
Jian=20

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Keria Seymour
Sent: Monday, March 13, 2006 8:55 AM
To: linux-omap-open-source@linux.omap.com
Subject: How to solve "lsmod :QM_MODULES: Function not implemented."?

Hi.

I want to use lsmod on OSK 5912, but when I use it, the message "lsmod
:QM_MODULES: Function not implemented" annoy me.

Do you know how to solve it?

Thanks~!!

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
