From: Devendra Kumar Madhesia <devendra.madhesia@flextronicssoftware.com>
Subject: How to use omap keypad driver function
Date: Fri, 18 Aug 2006 19:24:27 +0530
Message-ID: <OFBAB8A90A.203F7215-ON652571CE.004C6076-652571CE.004C8E1E@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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





Hi,

My objective is to create a user application program that will handle
keypad interrupt.

like in my program some method e.g

keyEvent(keyCode)
{
switch(keyCode)
{
case '1':
    do some operation;
case 'a':
   do some operation;
...............

}
}

But how can get these key event with keycode from omap keypad driver?
How to call omap keypad driver function from user space program?

In normal device driver, there is entry function (like ioctl,read,write
etc) in device driver but
in omap keypad driver code no entry function exists like this.


Thanks a lot.
Best Regards,
Devendra

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
