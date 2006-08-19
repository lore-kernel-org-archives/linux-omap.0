From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: How to use omap keypad driver function
Date: Sat, 19 Aug 2006 02:26:48 +0200
Message-ID: <fb249edb0608181726l5f3cdfe5md3718a079615a1fa@mail.gmail.com>
References: <OFBAB8A90A.203F7215-ON652571CE.004C6076-652571CE.004C8E1E@flextronicssoftware.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <OFBAB8A90A.203F7215-ON652571CE.004C6076-652571CE.004C8E1E@flextronicssoftware.com>
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
To: Devendra Kumar Madhesia <devendra.madhesia@flextronicssoftware.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 18/08/06, Devendra Kumar Madhesia
<devendra.madhesia@flextronicssoftware.com> wrote:
>
>
>
>
> Hi,
>
> My objective is to create a user application program that will handle
> keypad interrupt.
>
> like in my program some method e.g
>
> keyEvent(keyCode)
> {
> switch(keyCode)
> {
> case '1':
>     do some operation;
> case 'a':
>    do some operation;
> ...............
>
> }
> }
>
> But how can get these key event with keycode from omap keypad driver?
> How to call omap keypad driver function from user space program?

I think you shouldn't call the driver directly and rather use the
evdev interface or read from console. If evdev is enabled in your
kernel, the keypad driver will be accessible through /dev/input/eventX
(for example /dev/input/event0 if it's the only input device).
Your program should open() this node and read() from it data in form
of struct input_event (defined in <linux/input.h>). When read()
returns, probably a key has been pressed and .code contains a key
code.
if (buffer->type == EV_KEY)
  switch (buffer->code) {
    case KEY_A:
etc, that's what an X server does for example.

>
> In normal device driver, there is entry function (like ioctl,read,write
> etc) in device driver but
> in omap keypad driver code no entry function exists like this.
>
>
> Thanks a lot.
> Best Regards,
> Devendra
>
> ***********************  FSS-Unclassified   ***********************
> "DISCLAIMER: This message is proprietary to Flextronics Software
> Systems Limited (FSS) and is intended solely for the use of the
> individual to whom it is addressed. It may contain  privileged or
> confidential information and should not be circulated or used for
> any purpose other than for what it is intended. If you have received
> this message in  error, please notify the originator immediately.
> If you are not the intended recipient, you are notified that you are
> strictly  prohibited  from  using, copying, altering, or disclosing
> the contents of this message.  FSS  accepts no  responsibility  for
> loss or damage arising from the use of  the information transmitted
> by this email including damage from virus."
>
>
>
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
balrog 2oo6
