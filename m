From: "James Selvam" <james.iisc@gmail.com>
Subject: False dependancy for OMAP 1510 Innovator Touchscreen Configuration
Date: Sat, 27 May 2006 12:07:19 +0530
Message-ID: <fd1e34b0605262337h45be026ew3c17757cbab23994@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All,

There is a false dependency created on selection of CONFIG_TOUCHSCREEN_OMAP
(for Innovator OMAP 1510) to CONFIG_OMAP_TSC2101 under SSI devices. The sam=
e
may be removed since the Innovator OMAP 1510 uses ADS7846 and not the
TSC2101 SSI drivers.

Regards,
James Selvam.
