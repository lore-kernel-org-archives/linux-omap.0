From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 1/7
Date: Thu, 23 Feb 2006 00:16:17 +0200
Message-ID: <43FCE2B1.1070901@cc.jyu.fi>
References: <9268368b0602200944g1d20823cl3b0c2d2cbe95ee29@mail.gmail.com>	<20060220221115.23684.qmail@web32908.mail.mud.yahoo.com>
	<9268368b0602210414x6b760af1mcdd02b8f7bee18f7@mail.gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0602210414x6b760af1mcdd02b8f7bee18f7@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


>  
>
>>>+ *
>>>+ * History:
>>>+ *
>>>+ * 2005-07-29   INdT Kernel Team - Alsa driver for omap osk.
>>>Creation of new
>>>+ *                                 file omap-aic23.c
>>>+ *
>>>+ * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix
>>>as proposed by Ajaya Babu
>>>+ *
>>>+ * 2006-02-07   Daniel Petrini  - Codec specific function separated.
>>>File renamed to
>>>+ *                                omap-alsa.c
>>>+ * 2006-02-10        Mika Laitio     - Codec specific function pointers are set
>>>in the codec.
>>>+ *                             Default samplerate queried from the codec.
>>>+ */
>>>      
>>>
>>I am happy to see this big development and cleaned up driver interface,
>>but I think we can trim down this History as I believe GIT is being
>>really used for this purpose. Only thing we need to take care is give
>>better comment at patch submit time :)
>>    
>>
>
>Very good suggestion. We will keep in mind to do it from now on.
>  
>
Is there somekind of "kernel" policy for this one.
Can we leave the first (2005-07-29) and second one (2005-12-18) from the
history to next patch round or just remove everything?

Mika
