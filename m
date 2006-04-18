From: "prafulla chandra vejendla" <v.prafulla@gmail.com>
Subject: segmentation fault while accessing mcbsp1 port from the ARM
Date: Tue, 18 Apr 2006 16:07:25 +0530
Message-ID: <26d3a31c0604180337r76e326f9tb560c289e6e1ec6f@mail.gmail.com>
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

Hi all,
in OSK5912 board i am trying to access the McBSP port through ARM processor
in which LINUX 2.6.11.3  is ported. i am  trying to access McBSP1 using the
address 0xe1011806. but i am getting error as segmentation fault. why is it
so. any one come accross the problem.is there any other way to acces the
McBSP1 port there by AIC23  codec from the ARM processor.
thanks in advance
prafulla chandra
