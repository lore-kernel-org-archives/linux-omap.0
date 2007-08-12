From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: 2430 GPIO programming example ?
Date: Sun, 12 Aug 2007 08:59:16 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470184AB9D@dlee13.ent.ti.com>
References: <57314e840708120608i38c3f786rb8839c4dc42d75f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <57314e840708120608i38c3f786rb8839c4dc42d75f8@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

>can someone plz post or refer me to an example where I can
>learn how to programme the GPIO pins of the 2430 ?
>

The OMAP GPIO driver exports or provides following basic GPIO API that =
could be used by GPIO dependent drivers.

omap_request_gpio : First, request or reserve a GPIO pin (you should =
know which pin you wish to use). Non 0 return value means the GPIO you =
requested is already reserved.

omap_set_gpio_direction : A GPIO pin should be configured as input or =
output pin w.r.t processor. This function accepts pin number, direction =
(1 - input, 0 - output.

omap_set_gpio_dataout: Writes 1 or 0 for a GPIO pin, This function =
accepts pin number and data ( 0 , 1 makes sense).

omap_get_gpio_datain: Reads a GPIO pin. This function accepts pin number =
and returns the pin state.

omap_set_gpio_debounce : This is to enable debounce feature for a =
respective pin.

omap_set_gpio_debounce_time: This is to set the debounce time for a =
respective pin. You have enable the debounce feature along with this =
function.

omap_free_gpio : Finally un-reserve the GPIO pin requested or reserved.

Hope this helps. Refer to /drivers/input/touchscreen/ads7846.c for an =
example.

Regards
Khasim
