From: Devendra Kumar Madhesia <devendra.madhesia@flextronicssoftware.com>
Subject: Re: How to use omap keypad driver function
Date: Tue, 22 Aug 2006 17:30:37 +0530
Message-ID: <OFFA21831C.2B8E1DB7-ON652571D2.00373D79-652571D2.00422221@flextronicssoftware.com>
References: <fb249edb0608181726l5f3cdfe5md3718a079615a1fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0608181726l5f3cdfe5md3718a079615a1fa@mail.gmail.com>
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







Hi,
I am trying to open() and read() device file /dev/input/event0.
But read() system call doesn't return it hanged during that call.
Actually read() for /dev/input/event0 file return struct input_event
through which i want to get keycode.
Please help!

Code for reference is :

int main(int argc,char** argv)
{
.......................
.........................
fd = open(/dev/input/event0,O_RDONLY);

IOCTL(fd,EVIOCGNAME,&devName);
printf("Device name:%s,devName);
IOCTL(fd,EVIOCGPHYS,&location);
printf("Device physical location:%s,version);

struct input_event event[64];
while(1)
{
rd = read(fd,event,sizeof(struct input_event)*64);

for (i=0; i< rd/sizeof (input_event),i++)
 {
     if( event[i].type == EV_KEY)
    {
     switch(event[i].code)
       {
       case KEY_1:
........................
       }
    }
 }

}


}

output is : Device name AT Translated set 2 keyboard
                  Device physical location: isa0060/serio0/input0

;;;;;;;;;;;;;;;;;;;;;;;;after that blocked even while pressing key

reason: read() doesn't return
May be that it not recognizing keyboard.I am using PS2 keyboard.
if this is problem then what is device node for this keyborad?


Thanks
Best Regards,
Devendra


                                                                           
             "andrzej                                                      
             zaborowski"                                                   
             <balrog@zabor.org                                          To 
             >                         Devendra Kumar Madhesia/HSS@HSS     
             Sent by:                                                   cc 
             balrogg@gmail.com         linux-omap-open-source@linux.omap.c 
                                       om                                  
                                                                   Subject 
             08/19/2006 05:56          Re: How to use omap keypad driver   
             AM                        function                            
                                                                           
                                                                           
             Please respond to                                             
             balrogg@gmail.com                                             
                                                                           
                                                                           




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



***********************  FSS-Unclassified   ***********************
"DISCLAIMER: This message is proprietary to Flextronics Software
Systems Limited (FSS) and is intended solely for the use of the
individual to whom it is addressed. It may contain  privileged or
confidential information and should not be circulated or used for
any purpose other than for what it is intended. If you have received
this message in  error, please notify the originator immediately.
If you are not the intended recipient, you are notified that you are
strictly  prohibited  from  using, copying, altering, or disclosing
the contents of this message.  FSS  accepts no  responsibility  for
loss or damage arising from the use of  the information transmitted
by this email including damage from virus."
