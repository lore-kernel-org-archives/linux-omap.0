From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/7] arm/dts: Audio support for OMAP4 devices (SDP, PandaBoard)
Date: Fri,  8 Jun 2012 17:01:58 +0300
Message-ID: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello,

The following series enable the audio functionality on OMAP4 based devices using
twl6040 as audio codec.

The series adds the needed bindings in the dts for the OMAP IPs, twl6040 MFD
device and for the audio connection on the board.

To be able to differentiate between PandaBoard and PandaBoardES (they have a bit
different audio configuration) a new dts file has been created which only
changes the audio properties different between the two boards.

Patches for the drivers involved and the documentation related to dts sections
has been either in 3.5 or heading for 3.6.

Regards,
Peter
---
Peter Ujfalusi (7):
  arm/dts: omap4: Add entry for OMAP McPDM IP
  arm/dts: omap4: Add entry for OMAP DMIC IP
  arm/dts: omap4-sdp: Add fixed regulator to represent VBAT
  arm/dts: omap4-sdp: Add support for twl6040
  arm/dts: omap4-sdp: Enable audio support via device tree
  arm/dts: omap4-panda: Audio support for PandaBoard 4430
  arm/dts: New dts file for PandaBoardES (4460)

 arch/arm/boot/dts/omap4-panda.dts   |   37 +++++++++++++++++++
 arch/arm/boot/dts/omap4-pandaES.dts |   24 ++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts     |   68 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi        |   18 +++++++++
 4 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-pandaES.dts

-- 
1.7.8.6
