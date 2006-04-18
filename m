From: "RAVI SHANGAR" <ravishangar@gmail.com>
Subject: OMAP 1510 Camera sensor (ov6630) driver code
Date: Tue, 18 Apr 2006 14:42:54 +0530
Message-ID: <ade4abe50604180212q4447ac60n8a7d36e878f9a0d8@mail.gmail.com>
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

Previously, I got info about the 1510 camera driver that sensor_ov9640.c
must be modified for our ov66xx sensor.

But when I learnt ov9640 & ov6630 sensor specifications, they have more
similarities. Also the sensor code seems to be alright for atleast
*initialization
& detection* of ov6630 sensor chip.

When I tried with the camera driver, sensor initialization failed at
the *i2c_transfer(
)* function which returns -121 i.e., REMOTEIO error.

I am not aware of the significance of the error as well as where the source
of error lies ( with sensor code or sensor in camera itself).

The second doubt I have is the slave address for I2C driver used in ov9640.=
h

If OMAP_24xx_VIRTIO defined , addr is 0x60 or it is 0x30.

But in iBootHost given with OMAP board, Camera code uses 0x60 as the addr.

*QUERIES:*
*What's the exact address to be used? *
*In what places the sensor code is to be modified ?*
*I need to get MIDH and MIDL values from the sensor. Give the code changes
for this purpose atleast.*

Pl give a clear solution or sensor ov6630 code for OMAP camera  if
available.

Regards,
Ravishangar.K
