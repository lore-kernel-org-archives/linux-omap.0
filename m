From: "Sideleau, Scott R" <srs@WPI.EDU>
Subject: Bug? - OSK Frame Buffer Support in Kernel 2.6.18-omap1
Date: Fri, 6 Oct 2006 06:21:27 -0400
Message-ID: <CC7B089C59ED6841BAE28F1EA69A854387372B@EXCHDB.admin.wpi.edu>
References: <452628C9.1020603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <452628C9.1020603@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello,

When trying to build the 2.6.18-omap1 kernel with the frame buffer =
support
option for the OSK selected, the build fails while trying to compile
".../drivers/video/omap/omapfb_main.c" with numerous errors.

I selected frame buffer support as shown at the "OSK for Dummies" web =
site
(albeit without the "OMAP internal LCD controller support" option =
checked as
it apparently no longer exists)...

http://oskfordummies.hp.infoseek.co.jp/howto/lcd.html

Has anyone successfully built the 2.6.18-omap1 kernel with frame buffer
support?  Is my problem a known bug?  Any help is appreciated.

I am going to try to revert to a 2.6.14-omap1 kernel, but there are no
guarantees that the old build will resolve my problem.

Thanks, in advance.
______________________________________________
Scott R. Sideleau
ECE '07, Worcester Polytechnic Institute
@ MQP Ireland A'06, University of Limerick
+353 61-307310 / srs@wpi.edu
