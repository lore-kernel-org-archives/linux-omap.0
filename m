From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Wed, 03 Apr 2013 14:11:02 +0200
Message-ID: <515C1C56.6000103@gmail.com>
References: <509420D8.1030307@gmail.com> <C8443D0743D26F4388EA172BF4E2A7A93EA0A1F2@DBDE01.ent.ti.com> <51312430.6060306@gmail.com> <87sj4cunp6.fsf@dell.be.48ers.dk> <5133E268.5010604@gmail.com> <51388D64.9000005@gmail.com> <513A1580.90303@gmail.com> <514863BD.5010503@gmail.com> <87620nwmd2.fsf@dell.be.48ers.dk> <515C19D7.6080702@gmail.com> <20130403120454.GX25837@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130403120454.GX25837-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Santhapuri, Damodar" <damodar.santhapuri-l0cyMroinI0@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 03.04.2013 14:04, Felipe Balbi wrote:
> (sorry, being really busy lately)
> 
> On Wed, Apr 03, 2013 at 02:00:23PM +0200, Daniel Mack wrote:
>>>  >> I know this patch reintroduces bits that have been intentionally
>>>  >> removed before, in particular by 032ec49f53 ("usb: musb: drop
>>>  >> useless board_mode usage"), but I don't know how this usb driver is
>>>  >> supposed to work in host mode without taking the configured port
>>>  >> mode into account. If anyone can explain to me which information I'm
>>>  >> missing here, I can happily test a patch. For now, this works for
>>>  >> me.
>>>
>>>  Daniel> Hmm, nobody, really? Am I the only one who's running the musb
>>>  Daniel> driver in host-only mode?
>>>
>>> Sorry, I'll be needing host mode as well, but am currently stuck working
>>> on non-am335x stuff - So I'm definately interested in getting it to
>>> work, but don't have free cycles to look into it right now.
>>>
>>
>> Another two weeks passed with no answer at all, which makes me wonder
>> whether the changes were made considering the setup at all that at least
>> Peter, Koen and me are using.
>>
>> Felipe, could you explain the background on how the dsps driver is
>> supposed to work in host mode at boot time with the rework of the driver
>> you did for 3.7? It might just be me not understanding the rationale
>> behind all these changes, but appearantly, I'm not the only one who's
>> affected by that.
> 
> right, so the idea with that was to drop the huge amount of ifdeferry
> hack from the MUSB driver. It would be great if someone would send
> *CLEAN* patches adding Kconfig-based role choices again.
> 
> DWC3 and Chipidea are doing it very nicely.

Thanks a lot for your answer! I'll look into that and send some patches
then.


Thanks,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
