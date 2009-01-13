From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [REVIEW PATCH 00/14] OMAP3 camera + ISP + MT9P012 sensor driver v2
Date: Mon, 12 Jan 2009 20:03:05 -0600
Message-ID: <A24693684029E5489D1D202277BE894416429F96@dlee02.ent.ti.com>
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
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "Nagalla,
	Hari" <hnagalla@ti.com>, Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

I'm sending the following patchset for review to the relevant lists (linu=
x-omap, v4l, linux-media).

Includes:
 - Omap3 camera core + ISP drivers.
 - MT9P012 sensor driver (adapted to 3430SDP)
 - DW9710 lens driver (adapted to work with MT9P012 for SDP)
 - Necessary v4l2-int-device changes to make above drivers work
 - Redefine OMAP3 ISP platform device.
 - Review comments fixed from: (Thanks a lot for their time and help)
   - Hans Verkuil
   - Tony Lindgreen
   - Felipe Balbi
   - Vaibhav Hiremath
   - David Brownell

Some notes:
 - Uses v4l2-int-device solution.
 - Tested with 3430SDP ES3.0 VG5.0.1 with Camkit v3.0.1
 - Applies cleanly on top of commit 0ec95b96fd77036a13398c66901e11cd30119=
0d0 by Jouni Hogander (OMAP3: PM: Emu_pwrdm is switched off by hardware e=
ven when sdti is in use)
 - ISP wrappers dropped from the patchset, as a rework is going on curren=
tly.


I appreciate in advance your time.

Regards,
Sergio

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
