From: "Deepak Barua" <dbbarua@gmail.com>
Subject: Re: Tool Chain setting for OMAP 5912 board
Date: Thu, 11 Jan 2007 09:26:14 +0530
Message-ID: <b5a19cd20701101956p42a4927fp6fef5e5381d0d1db@mail.gmail.com>
References: <b5a19cd20701101934k23cba1fak703661fe2d019f6e@mail.gmail.com>
	<45A5B123.7010000@gmail.com>
	<b5a19cd20701101946j3630fd96w298fec20dcc2bf0a@mail.gmail.com>
	<45A5B45D.1030000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <45A5B45D.1030000@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,
                   I don't know what EABI means i am using a  ubuntu
system with 2.6.15-23-386 #1 PREEMPT kernel and i am trying to compile
the kernel without any TI tools .... if you get my point a raw kernel
build is what i ama looking for ...

Regards
Deepak

On 1/11/07, Nishanth Menon <menon.nishanth@gmail.com> wrote:
> Deepak Barua stated on 1/10/2007 9:46 PM:
> >                   Thats okay i know that but what about the library
> > files... how will they be included....?
> Leave that to the kernel make files.. usually kernel does not depend on
> gcclib etc.. just ensure that u have the ABI options set properly (EABI
> enabled if ur using a EABI fileystem compiled with a EABI compiler)..
> Regards,
> Nishanth Menon
>


-- 
Code Code Code Away
