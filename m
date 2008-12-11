From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [REVIEW PATCH 00/14] OMAP3 camera + ISP + MT9P012 sensor driver
Date: Thu, 11 Dec 2008 14:37:43 -0600
Message-ID: <A24693684029E5489D1D202277BE894415E6E194@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>
Cc: Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "Nagalla,
	Hari" <hnagalla@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

I'm sending the following patchset for review to the relevant lists (linu=
x-omap and v4l).

Includes:
 - Omap3 camera core + ISP drivers.
 - Preview and Resizer Wrappers for Memory to Memory operation of the ISP=
.
 - MT9P012 sensor driver (adapted to 3430SDP)
 - DW9710 lens driver ()
 - Necessary v4l2-int-device changes to make above drivers work

Some notes:
 - Uses v4l2-int-device solution.
 - Tested with 3430SDP ES3.0 VG5.0.1 with Camkit v3.0.1
 - Applies cleanly on top of commit 249d6164958e1c8de46fbb30396de9ae6e9a3=
a50 by David Brownell (ARM: OMAP: use gpio_to_irq)
 - Needed "ARM: OMAP: use GPIO standard in OneNAND driver" patch to be ab=
le to compile resulting kernel image using omap_3430sdp_defconfig.

I appreciate in advance your time.

Regards,
Sergio

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
