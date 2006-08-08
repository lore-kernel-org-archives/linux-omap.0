From: Vladimir <vovan888@gmail.com>
Subject: Re: mcbsp
Date: Tue, 8 Aug 2006 17:19:10 +0400
Message-ID: <ce55079f0608080619h8c565c4rf22bbb26a5913c4f@mail.gmail.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBEE6BA20@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBEE6BA20@DLEE09.ent.ti.com>
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
To: "Khasim, Syed" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

It is also possible to use some lines of any McBSP port by changing
line states directly writing to McBSP registers.

2006/8/8, Khasim, Syed <x0khasim@ti.com>:
> Is LED connected to McBSP lines and you want to operate them (McBSP
> lines) in GPIO mode? This is possible by changing the mux settings of
> McBSP lines to GPIO mode and use the GPIO APIs to read and write to
> them.
>
> Regards,
> Khasim
>
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
> Arnold
> Sent: Tuesday, August 08, 2006 3:34 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: mcbsp
>
> Hi guys,
>
> Is there anyone who knows about mcbsp? Is it possible
> to connect a button or a led to it? If yes, how is it
> done? Is it the same as programming the gpio? I hope
> there's someone who could help me.
>
> Thanks,
> Oj
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
