From: Denis Kenzior <denkenz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Motorola motmdm support
Date: Sun, 30 Dec 2018 13:13:24 -0600
Message-ID: <ea54fd64-d45f-7324-c5a9-6044ff34bb23@gmail.com>
References: <20181229094953.GA15358@amd>
 <e959006f-5f8d-8d25-b9d2-dbbcb6a5b073@gmail.com> <20181229220856.GA28688@amd>
 <2e54ecb4-e104-5d1d-5e5c-274ee13b7d73@gmail.com>
 <20181230181419.GE6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
In-Reply-To: <20181230181419.GE6707-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: mpartap-hi6Y0CQ0nG0@public.gmane.org, merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nekit1000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

>> It might make your job easier if the oFono driver itself invoked the
>> necessary magic to setup the multiplexer and handed off the devices as
>> needed.  We used to have a driver like this, but not sure if it ever made it
>> upstream.
> 
> Playing with ldattach and user space handling earlier this year did
> not work out good.. It needed app specific handling for the Motorola
> custom layer on top of ts 27.010, custom handling for all the devices
> such as GNSS and audio mixer, and did not work well with device
> specific power management. So let's not go back to that :)

You still need someone to send AT+CMUX, no?  And you most likely need to 
integrate power management into the telephony stack anyway.  As I 
mentioned, we had a driver like this that worked just fine.  oFono ended 
up using a user space MUX since most of the quality of life improvements 
to n_gsm came in much later.  If I was writing a new MUXed driver these 
days, I'd seriously consider using GSMIOC_SETCONF and GSMIOC_ENABLE_NET.

How does the audio mixer handling work?  Just some AT commands to setup 
the mixing parameters, or something more involved?

Some other things to consider:
- oFono expects / is designed to expect exclusive access to all the tty 
ports
- GNSS/GPS is intended to be handled via oFono LocationReporting API.  I 
would recommend integrating this as intended...

> 
>>> One more question: I guess I'll need to implement this... Is there
>>> another example of driver doing AT commands but on multiple file
>>> descriptors? I could really use something to look at as a template..
>>
>> Any driver for a USB based device would be setup this way.  Each AT port is
>> a separate file, e.g. ttyUSB1, ttyACM2, etc.  The discovery is done via
>> udev.  See plugins/mbm.c or plugins/ublox.c or plugins/telit.c, etc.
>>
>> Assuming you don't want to setup the multiplexer in oFono, then the only
>> tricky part is the port setup.  udevng.c setup_serial_modem() assumes a
>> single port, so you might need to add some extra logic to setup the ports
>> via udev rules.
> 
> We have network status data at /dev/motmdm1, outgoing SMS PDU device at
> /dev/motmdm3, incoming SMS PDU device at /dev/motmdm9 and so on for each
> ts 27.010 channel. At least incoming and outgoing SMS PDU devices could
> be considered as separate modems if that makes things easier?

No, that just makes things more difficult.

> 
>> Alternatively, simply use a config file specific to your driver.  See for
>> example how plugins/phonesim.c does this.
>>
>> Or, if it is an extremely platform specific driver, then just hardcode it.
>> E.g. like plugins/calypso.c, which only works for the Freerunner.
> 
> Just adding one more thing to consider: Looks like the modem handling for
> SMS PDU's needs to be specific to the nework. First the network needs to
> be detected, and then the GSM or CDMA handlers need to be used for sending
> and receiving SMS. After that things should get standard.. Looks like
> ofono has parsing for the different type SMS PDUs in src/*sms*.c :)
> 

There's no real functional CDMA support in oFono anyhow.  Given that 
most CDMA networks are about to be switched off, I don't know why you 
would bother?

Regards,
-Denis
