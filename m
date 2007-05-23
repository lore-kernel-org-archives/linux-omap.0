From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] MUSB HSET driver
Date: Wed, 23 May 2007 15:14:45 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC0800305CC70@dbde01.ent.ti.com>
References: <200705230234.37346.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200705230234.37346.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>On Wednesday 23 May 2007, Pandita, Vikram wrote:
>> Hi Tony
>> As per Greg's suggestion of introducing HSET driver in ope
>> n source, can we push the HSET driver into MUSB for now till
>> a complete implementation is made available in open source?
>
>Please, no.
>
>This doesn't need to be musb-specific, and if it gets merged
>it'll just create more pain to rip it out when musb_hdrc goes
>upstream.

Agreed

>
>A much cleaner approach is to just do this in userspace with
>usbfs ... issuing control requests to the hub ports.  That
>will work with *ANY* high speed controller.

I think Felipe Balbi will be looking into that aspect.

But how will that work for HSET tests with OPT card with OMAP as host.
We still need to write a class driver that issues the TEST command to =
hub based on VID/PID sent by OPT. And that is what I am proposing.
Comments please.

>
>If the existing test mode support in the musb root hub is not
>enough, just fix that bug.

The musb hset current implementation that I have does not use the =
USB_PORT_FEAT_TEST path of the HUB but a custom test path.=20
Based on your inputs for generic class driver for OPT, I will make the =
changes.


>
>- Dave
