From: =?ISO-8859-1?Q?Jos=E9_Miguel_Gon=E7alves?= <jose.goncalves@inov.pt>
Subject: Problem with a hih6130 sensor in a OMAP I2C bus
Date: Mon, 09 Dec 2013 11:42:13 +0000
Message-ID: <52A5AC95.3050803@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lm-sensors-bounces@lm-sensors.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/options/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/lm-sensors/>
List-Post: <mailto:lm-sensors@lm-sensors.org>
List-Help: <mailto:lm-sensors-request@lm-sensors.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=subscribe>
Sender: lm-sensors-bounces@lm-sensors.org
Errors-To: lm-sensors-bounces@lm-sensors.org
To: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org
List-Id: linux-omap@vger.kernel.org

Hi,

While testing an HIH6130 humidity and temperature sensor with I2C =

interface in a BeagleBone board I've found that I was unable to read it =

because the driver always returned EINVAL. With some debugging I've =

found that the error was due to a test on omap_i2c_xfer_msg() in OMAP =

I2C driver that invalidates zero length writes. The hwmon hih6130 driver =

issues such kind of request in hih6130_update_measurements() to issue a =

measurement request to the sensor.

I was able to get measurements from the sensor by hacking the hih6130 =

driver replacing the following line in hih6130_update_measurements();

         ret =3D i2c_master_send(client, tmp, 0);

by

         tmp[0] =3D 0;
         ret =3D i2c_master_send(client, tmp, 1);

Is this the correct way to fix this issue, or should the fix be in the =

I2C OMAP driver to accept zero length transfers?

Best regards,
Jos=E9 Gon=E7alves

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
