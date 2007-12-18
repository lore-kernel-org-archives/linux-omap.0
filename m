From: "Carl Benson" <Carl.Benson@combra.se>
Subject: RE: ethernet performace on 3430SDP ES1.0
Date: Tue, 18 Dec 2007 16:19:18 +0100
Message-ID: <D0D7E940253EF8428A27241F8E3CABA3A88E10@zeus.Combra.se>
References: <D0D7E940253EF8428A27241F8E3CABA3A88E0F@zeus.Combra.se>
	<7EAD1AEEA7621C45899FE99123E124A0014BD43B@dbde01.ent.ti.com>
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
To: "Syed Mohammed, Khasim" <khasim@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Khasim. CPU_IDLE was not defined, however I disabled options =
CONFIG_NO_HZ, CONFIG_HIGH_RES_TIMERS and CONFIG_TICK_ONESHOT and it =
works without any hassle now.
=20
Thanks!
/carl
=20

________________________________

From: Syed Mohammed, Khasim [mailto:khasim@ti.com]
Sent: Tue 12/18/2007 4:05 PM
To: Carl Benson; linux-omap-open-source@linux.omap.com
Subject: RE: ethernet performace on 3430SDP ES1.0





> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Carl Benson
> Sent: Tuesday, December 18, 2007 7:51 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: ethernet performace on 3430SDP ES1.0
>
> Hi. Trying TI kernel 2.6.22.1 available from linux.omap.com and =
experience
> some bad networking performance on the 3430SDP ES1.0 card which I did =
not
> see with the newer kernels from linux-omap project.
>
<Snip>

Can you disable cpu_idle in menuconfig and try again?

Regards,
Khasim
