From: "Deepak Barua" <dbbarua@gmail.com>
Subject: Re: Tool Chain setting for OMAP 5912 board
Date: Thu, 11 Jan 2007 09:16:39 +0530
Message-ID: <b5a19cd20701101946j3630fd96w298fec20dcc2bf0a@mail.gmail.com>
References: <b5a19cd20701101934k23cba1fak703661fe2d019f6e@mail.gmail.com>
	<45A5B123.7010000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45A5B123.7010000@gmail.com>
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
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,
                   Thats okay i know that but what about the library
files... how will they be included....?

Regards
Deepak

On 1/11/07, Nishanth Menon <menon.nishanth@gmail.com> wrote:
> Deepak Barua stated on 1/10/2007 9:34 PM:
> > Hi ,
> >      I have used crosstool to compile a tool chain for the OMAP 5912
> > board the architecture i used is ARM v5 softfloat.
> >
> > I want to know how to change the gcc and include files to library path
> > so i can use this cross compiler to compile a new kernel for the OMAP
> > board.
> setup the cross compile binary path in ur $PATH variable, and try giving
> CROSS_COMPILE=arm-linux-xyz (if your compiler is arm-linux-xyz-gcc) in
> the make options to the kernel (e.g. make CROSS_COMPILE=arm-linux-xyz
> uImage and so on)
> Regards,
> NM
>


-- 
Code Code Code Away
