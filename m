From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [RFC PATCH 3/3] net: ethernet: ti: cpsw: add XDP support
Date: Thu, 18 Apr 2019 11:44:26 -0700
Message-ID: <20190418114426.0a0b26f9@cakuba.netronome.com>
References: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
        <20190417174942.11811-4-ivan.khoronzhuk@linaro.org>
        <CAJpBn1y0odvL97-kP5yzKC+tN=fx178nxigfBfDwXhRhPRvDuQ@mail.gmail.com>
        <20190418094008.GB27879@khorivan>
        <20190418104111.559a0e74@cakuba.netronome.com>
        <20190418183043.GD27879@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418183043.GD27879@khorivan>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux Netdev List <netdev@vger.kernel.org>, ilias.apalodimas@linaro.org, hawk@kernel.org, xdp-newbies@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, aniel@iogearbox.net, John Fastabend <john.fastabend@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 18 Apr 2019 21:30:44 +0300, Ivan Khoronzhuk wrote:
> >> Here another thing bothering me, I send it to queue 0 always, instead of
> >> taking cpu num. Not sure about this, but I expect to have some tx queue
> >> not bind to cpu and didn't find a way it can be changed dynamically in
> >> redirect.  
> >
> >Not sure I understand :)  
> 
> I mean, is there a capability to choose tx queue while XDP_REDIRECT or XDP_TX.
> 
> From what I've seen it's taken by:
> qidx = smp_processor_id();
> 
> What if I need to send classified traffic to hw queue 4 for instance...

I see, no we don't have any API for that, yet.  I think all NICs which
implement XDP REDIRECT today will allocate a single normal prio queue
per CPU..
