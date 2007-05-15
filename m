From: Samuel HUO <samuel.huo@st.com>
Subject: XIP on OSK5912
Date: Tue, 15 May 2007 20:15:42 +0800
Message-ID: <001501c796ea$c4ba5d10$57c7c68a@st.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

I have some problem when running 2.6 XIP kernel on OSK5912. It seemed =
uboot doesn't support compiled XIP kernel currently. Is there any =
workaroud to fix this problem? Or is there any free bootloader but uboot =
to use?

Actually, my aim is to test application XIP provided by Linear CramFS =
XIP Patch. I have read a doc from below link.
http://www.denx.de/wiki/bin/view/DULG/ConfigureLinuxForXIP
"the current implementation (Linear cramfs XIP) can only be used =
together with a XIP kernel, which provides the appropriate XIP memory =
(FLASH) mapping."
Does anyone know what kind of FLASH mapping should I add to cramfs, thus =
cramfs XIP can run standalone without Kernel XIP?

Best Regards,
Samuel
