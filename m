From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Tool Chain setting for OMAP 5912 board
Date: Wed, 10 Jan 2007 21:51:57 -0600
Message-ID: <45A5B45D.1030000@gmail.com>
References: <b5a19cd20701101934k23cba1fak703661fe2d019f6e@mail.gmail.com>	
	<45A5B123.7010000@gmail.com>
	<b5a19cd20701101946j3630fd96w298fec20dcc2bf0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <b5a19cd20701101946j3630fd96w298fec20dcc2bf0a@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Deepak Barua <dbbarua@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Deepak Barua stated on 1/10/2007 9:46 PM:
>                   Thats okay i know that but what about the library
> files... how will they be included....?
Leave that to the kernel make files.. usually kernel does not depend on
gcclib etc.. just ensure that u have the ABI options set properly (EABI
enabled if ur using a EABI fileystem compiled with a EABI compiler)..
Regards,
Nishanth Menon
