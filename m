From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 2/7
Date: Wed, 22 Feb 2006 01:53:10 +0200
Message-ID: <43FBA7E6.2080103@cc.jyu.fi>
References: <9268368b0602200947g57ed39d6y28d4612ed4278cda@mail.gmail.com><520AB2AD990DC04082102F77CA1726381036EB@dlee03.ent.ti.com>	<9268368b0602210606y5a84b111g459f2b293d4ece4@mail.gmail.com>
	<520AB2AD990DC04082102F77CA1726381036EF@dlee03.ent.ti.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <520AB2AD990DC04082102F77CA1726381036EF@dlee03.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Menon, Nishanth" <x0nishan@ti.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


>>You mean the codec files moving to sound/ ? With this board file
>>approach this cause problems in linking the codec functions in the
>>board file. They had to stay in the omap tree not in the sound/ .
>>Maybe a better place to them could be plat-omap/ ?
>>    
>>
>I dont see plat-omap having stuff other than omap specific code - such as dma etc.. if we put peripheral chip specific code there, i dont see kernel directory's abstraction happening properly sound/.. is the perfect place for this. The issue of linking is a minor problem - which can be handled by using proper include files.
>Regards,
>  
>
Hi,

We have put the audio codec files under /arm/arch because we have wanted
to share the same omap-alsa.c between both codecs.
And for that reason we need to set the function pointers to omap-alsa.c
so that the calls from omap-alsa.c ends up to correct codec.

We have tried to do couple of different method for implementing this and
have not sofar found any perfect solution.

In our first attempt we kept all alsa related files in sound/arm/omap
directory.
In addition we put get_codec_functions() method to both of the drivers
and when the module was loaded the omap-alsa.c
called this get_codec_functions() method. The method had one
disadvantage, user could not build aic23 and tsc2101 drivers to same kernel
as both of the drivers had this one function with the same name.

In our second attemt (the one included in patches) we put the board-code
to set the function pointers. The drawback in this
method is that the functions defined in the board-code must itself be
linked within the board-code, otherwise we
got linking errors in the end.

Third (non tested) alternative could work in the following way
- Move the alsa modules probe method to codecs.
- when probe is called, it could define the function pointers and set
them to omap-alsa.c

Fourth possibility I know would be to make own implementation from
omap-alsa.c both for both of the codecs
but that is something I would like to avoid.

So if you have some idea how to do this, can you give us some info how
to do that.

Mika
