From: "Minjie Lin" <MLin@EmpowerTechnologies.com>
Subject: RE: How to solve "lsmod :QM_MODULES: Function not implemented."?
Date: Tue, 14 Mar 2006 12:08:15 -0700
Message-ID: <6632A2E3A760EA41B6A08F2A8B02C34C8C0A24@BBSC-EX01.bbsconnect.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Keria Seymour <subsun.ece94g@nctu.edu.tw>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

=20
Hi
That's because you used linux 2.4 modules utilities. To fix this problem
is to use
Linux 2.6 modules utilities. You can copy the moduitilities from 2.6
files system or
Use tools to generate them such as busybox 1.01 and later version.

Regards,

Minjie


-----Original Message-----
From:
linux-omap-open-source-bounces+mlin=3Dempowertechnologies.com@linux.omap.=
c
om
[mailto:linux-omap-open-source-bounces+mlin=3Dempowertechnologies.com@lin=
u
x.omap.com] On Behalf Of Keria Seymour
Sent: March 14, 2006 5:55 AM
To: linux-omap-open-source@linux.omap.com
Subject: How to solve "lsmod :QM_MODULES: Function not implemented."?

Thank you very much...

But do you know the method about how to solve this question in detail?

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
