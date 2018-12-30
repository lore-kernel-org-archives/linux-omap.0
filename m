From: Denis Kenzior <denkenz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Motorola motmdm support
Date: Sat, 29 Dec 2018 18:14:06 -0600
Message-ID: <2e54ecb4-e104-5d1d-5e5c-274ee13b7d73@gmail.com>
References: <20181229094953.GA15358@amd>
 <e959006f-5f8d-8d25-b9d2-dbbcb6a5b073@gmail.com> <20181229220856.GA28688@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
In-Reply-To: <20181229220856.GA28688@amd>
Content-Language: en-US
List-Unsubscribe: <https://lists.ofono.org/mailman/options/ofono>,
 <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ofono.org/pipermail/ofono/>
List-Post: <mailto:ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
List-Help: <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ofono.org/mailman/listinfo/ofono>,
 <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=subscribe>
Errors-To: ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org
Sender: "ofono" <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: mpartap-hi6Y0CQ0nG0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nekit1000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

>> Kernel 27.010 multiplexer or something else entirely?
> 
> Kernel 27.010 multiplexer, AFAICT. Some of the endpoints are handled
> in kernel (gps, audio mixer control).
> 

Who sets up the multiplexer? Kernel?

It might make your job easier if the oFono driver itself invoked the 
necessary magic to setup the multiplexer and handed off the devices as 
needed.  We used to have a driver like this, but not sure if it ever 
made it upstream.

> 
> One more question: I guess I'll need to implement this... Is there
> another example of driver doing AT commands but on multiple file
> descriptors? I could really use something to look at as a template..

Any driver for a USB based device would be setup this way.  Each AT port 
is a separate file, e.g. ttyUSB1, ttyACM2, etc.  The discovery is done 
via udev.  See plugins/mbm.c or plugins/ublox.c or plugins/telit.c, etc.

Assuming you don't want to setup the multiplexer in oFono, then the only 
tricky part is the port setup.  udevng.c setup_serial_modem() assumes a 
single port, so you might need to add some extra logic to setup the 
ports via udev rules.

Alternatively, simply use a config file specific to your driver.  See 
for example how plugins/phonesim.c does this.

Or, if it is an extremely platform specific driver, then just hardcode 
it.  E.g. like plugins/calypso.c, which only works for the Freerunner.

Regards,
-Denis
